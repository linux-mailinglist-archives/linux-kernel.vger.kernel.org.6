Return-Path: <linux-kernel+bounces-313927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A8B96AC73
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F5CEB22E98
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806B1D79B5;
	Tue,  3 Sep 2024 22:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vfBZVtfE"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4EB1D79AC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403444; cv=none; b=DUfd36bbtGARNH14uRG9YFuWC4JRV+TEHqoYVcZiijfX/sXVsavVjR9hgE1pKWNWvSNL7yzkcn9LBTBvFLT8o4t8pvD3IlTefYV7HmFYBgX4dEcu7rlH3AfG5wdP4lKk6gsedfpjK+lH1kjk0mORt8VWDDZF69J/KBTSneRez0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403444; c=relaxed/simple;
	bh=VsQqZDG2vBkI+eXEfS0UyulsTVQLmn6XK55CtbICdfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OuQadkDL7VH5v/tDgVNcfy7hdM4SGnUVHj3Dv5d3qVhGkewCCWaOAGCb02JLS+AjWtU2P5Wh77zn+4bTmdfxamTYWXFTu6Uq/V6S7ctk5LG9h809me+7qSsTK5f9S3RMPjH52uuLU+XsMHP0AIdLlT8TEij39aapGjwNbdZInlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vfBZVtfE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20551e2f1f8so29359965ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725403441; x=1726008241; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bvrknjg9/RM1zG5XJW3ld7rYD1n+1qtWQFA9C2XoUUM=;
        b=vfBZVtfE/tvdmkZQX+hJafNdATqObPDbgUOXKyE2Tsk890qAh4P+H7P90ip12b1Zjt
         BCvQvTaJPmL0EwzKbSKFxhJyueySK3yOoawXpObM6XwgY3Y5e27AvV+iAgBu9Qa59L8f
         VFfwEg7zjr4ZKQxM8W5hJMz6tXpCXGJiEAOJ3x4sA2A3PC5zOBQFZYc2dy9ed7DJNlyg
         SPTNOLLJw3b9NLY0vqFrBBo///yqmQkzkgqnJkSL0GLUbU7Z29+UPYXM58Q6qogss5aZ
         TCeWkjKFEblGTn074m+MH/OwdSvYgHIS6Mu7AS3tcxfaykroMnnZb7gh896EgwiQXy0+
         CizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725403441; x=1726008241;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bvrknjg9/RM1zG5XJW3ld7rYD1n+1qtWQFA9C2XoUUM=;
        b=M9injPKk9bX+DseISHUc6lB6PC6rYReX4qoTG1WE4ux+YA2wQwd3gxX0eTP3NdrFDc
         fKMONWyORYBWhaGHGzQASPd17NjdaLL6IWww4aZVMmSpRpqhpIR9TGYgtItm0zs41MVk
         C/JELxOXdeeelDeXM7jHAUIGZ0o8f79eG+GI+7Z3+XUzq/oM80CIiy6hCmwV2k7GUUd2
         cGeo4Otomry1bbSbuXnfJdjWkkGTL94o4aB7IapS74h9dUuDU6QU+cBBLPeAhq4ygSPE
         +7mUTxwTmiAIUBmIYkoG3OIeqc5NvN0THEitP7sh8AoFlviZW+Cknltx+2vOXTqBBXIa
         pqMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Hx77NMX+RVxD3eKDYOPplTHs1nseM5G0PTPu2xUoMekr/csnXfyWalpn235xXeGNDsf79G/RvfSiPbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrTeQD094HqXDX/hGLIdybuj7a67zArjQewMEAwZUhTqR5Rds
	Wi4bDuJGly80cijBOL9JkgYAccyAaLX16JI99OskWMdgYVAiDjjCk+eDxp1CsTY=
X-Google-Smtp-Source: AGHT+IFP6zwZ5Ulrz5XMWt830yy+etLxuUKvrpgANXkVKwnXOXO10dHpQPm3s4aOjQg34IuTWI2T2g==
X-Received: by 2002:a17:902:e891:b0:203:a11a:30c8 with SMTP id d9443c01a7336-20584223058mr83299425ad.43.1725403440983;
        Tue, 03 Sep 2024 15:44:00 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea5582csm3001565ad.221.2024.09.03.15.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:44:00 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 03 Sep 2024 15:43:55 -0700
Subject: [PATCH v2] riscv: Fix race condition with
 PR_RISCV_CTX_SW_FENCEI_OFF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-fix_fencei_optimization-v2-1-c266ac8b9160@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIACqR12YC/x2MQQqAMAzAviI9O6hVQfyKiIzZaQ9O2URE2d8tH
 gNJXkgchRP0xQuRL0myBwUqC3CrDQsbmZWBkBrsKjJe7slzcCzTfpyyyWNPbUztu8o6QmyxBa2
 PyKr+52HM+QPabkXyaQAAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9798; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=VsQqZDG2vBkI+eXEfS0UyulsTVQLmn6XK55CtbICdfw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9r1ifrPdKPnBQUffZKw+mrixLPbKid9iLb4td6z98Q+b
 79Cr13uHaUsDGIcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEykfzfD//Lrf6Miea7OnXZl
 2kEd82s1cj1cV0SYN1Yb2l1SsXttUMvIcH7PvYks5ZkJn2ufzu1tnmPOf3OpzZ8tuZKLJR5wM+8
 L4gYA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

It is possible for mm->context.icache_stale_mask to be set between
switch_mm() and switch_to() when there are two threads on different CPUs
executing in the same mm. switch_mm() currently assumes that switch_to()
will handle the flushing. However if mm->context.icache_stale_mask is
changed in the middle, neither switch_mm() nor switch_to() will issue
the necessary flush. This situation can be seen in the following example
trace:

<---- Thread 1 starts running here on CPU1

<---- Thread 2 starts running here with same mm

T2: prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_FENCEI_ON, PR_RISCV_SCOPE_PER_PROCESS);
T2: <-- kernel sets current->mm->context.force_icache_flush to true
T2: <modification of instructions>
T2: fence.i
T2: fence w, w

T1: fence r, r
T1: fence.i (both fences to synchronize with other thread, has some logic to
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

This commit fixes this issue by modifying the semantics of
mm->context.force_icache_flush to mean that the mm will need to be
flushed at some point before returning to userspace. The flush will only
happen if task->mm->context.icache_stale_mask for this hart is set.
Once the flush has occurred, the bit in
task->mm->context.icache_stale_mask is cleared. Before returning back to
userspace, task->mm->context.icache_stale_mask is set again if
mm->context.force_icache_flush is set.

This ensures that even if PR_RISCV_CTX_SW_FENCEI_OFF is called between
switch_mm() and switch_to(), an icache flush is still emitted.

This also remedies the issue that it is possible for switch_mm() to be
called without being followed by switch_to() such as with the riscv efi
driver in efi_virtmap_load(), so we cannot do all of the flushing in
switch_to().

To ensure that the writes to mm->context.icache_stale_mask,
mm->context.force_icache_flush, and thread.force_icache_flush are
visible to all harts, add read/write barriers around their uses. One
thread on some hart will be responsible for doing
PR_RISCV_CTX_SW_FENCEI_ON and PR_RISCV_CTX_SW_FENCEI_OFF. There may be
threads in the same mm on different harts that need to see the changes
to these values that occurs when the prctl is started/stopped.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 6b9391b581fd ("riscv: Include riscv_set_icache_flush_ctx prctl")
---
Changes since v1:
- Split this patch into a separate series
- Add memory barriers as suggested by Andrea
- Only set the icache_stale_mask on PR_RISCV_SCOPE_PER_PROCESS
- Clarify race condition and how this patch solves the issue
- Link to v1: https://lore.kernel.org/lkml/20240813-fix_fencei_optimization-v1-0-2aadc2cdde95@rivosinc.com/
---
 arch/riscv/include/asm/switch_to.h | 43 +++++++++++++++++++++++++++++++++---
 arch/riscv/mm/cacheflush.c         | 45 ++++++++++++++++++++++++++++++--------
 arch/riscv/mm/context.c            | 12 +++++-----
 3 files changed, 82 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 7594df37cc9f..6f8c97971a45 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -76,11 +76,48 @@ extern struct task_struct *__switch_to(struct task_struct *,
 static inline bool switch_to_should_flush_icache(struct task_struct *task)
 {
 #ifdef CONFIG_SMP
-	bool stale_mm = task->mm && task->mm->context.force_icache_flush;
-	bool stale_thread = task->thread.force_icache_flush;
+	bool stale_mm = false;
 	bool thread_migrated = smp_processor_id() != task->thread.prev_cpu;
+	bool stale_thread;
+
+	/*
+	 * This pairs with the smp_wmb() in each case of the switch statement in
+	 * riscv_set_icache_flush_ctx() as well as the smp_wmb() in set_icache_stale_mask().
+	 *
+	 * The pairings with the smp_wmb() in the PR_RISCV_SCOPE_PER_PROCESS
+	 * cases in riscv_set_icache_flush_ctx() synchronizes this hart with the
+	 * updated value of current->mm->context.force_icache_flush.
+	 *
+	 * The pairings with the smp_wmb() in the PR_RISCV_SCOPE_PER_THREAD cases
+	 * in riscv_set_icache_flush_ctx() synchronizes this hart with the
+	 * updated value of task->thread.force_icache_flush.
+	 *
+	 * The pairing with the smp_wmb() in set_icache_stale_mask()
+	 * synchronizes this hart with the updated value of task->mm->context.icache_stale_mask.
+	 */
+	smp_rmb();
+	stale_thread = thread_migrated && task->thread.force_icache_flush;
+
+	if (task->mm) {
+		/*
+		 * The mm is only stale if the respective CPU bit in
+		 * icache_stale_mask is set.
+		 */
+		stale_mm = cpumask_test_cpu(smp_processor_id(),
+					    &task->mm->context.icache_stale_mask);
+
+		/*
+		 * force_icache_flush indicates that icache_stale_mask should be
+		 * set again for this hart before returning to userspace. This
+		 * ensures that next time this mm is switched to on this hart,
+		 * the icache is flushed only if necessary.
+		 */
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
index a03c994eed3b..8a40ea88ec61 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -158,20 +158,25 @@ void __init riscv_init_cbo_blocksizes(void)
 #ifdef CONFIG_SMP
 static void set_icache_stale_mask(void)
 {
-	cpumask_t *mask;
-	bool stale_cpu;
-
 	/*
 	 * Mark every other hart's icache as needing a flush for
-	 * this MM. Maintain the previous value of the current
-	 * cpu to handle the case when this function is called
-	 * concurrently on different harts.
+	 * this MM.
 	 */
+	cpumask_t *mask;
+	bool stale_cpu;
+
 	mask = &current->mm->context.icache_stale_mask;
 	stale_cpu = cpumask_test_cpu(smp_processor_id(), mask);
 
 	cpumask_setall(mask);
 	cpumask_assign_cpu(smp_processor_id(), mask, stale_cpu);
+
+	/*
+	 * This pairs with the smp_rmb() in switch_to_should_flush_icache() and
+	 * flush_icache_deferred() to ensure that the updates to
+	 * icache_stale_mask are visible in other harts.
+	 */
+	smp_wmb();
 }
 #endif
 
@@ -228,9 +233,22 @@ int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
 		switch (scope) {
 		case PR_RISCV_SCOPE_PER_PROCESS:
 			current->mm->context.force_icache_flush = true;
+			/*
+			 * This pairs with the smp_rmb() in
+			 * switch_to_should_flush_icache() to ensure that other
+			 * harts using the same mm flush the icache on migration.
+			 */
+			smp_wmb();
+			set_icache_stale_mask();
 			break;
 		case PR_RISCV_SCOPE_PER_THREAD:
 			current->thread.force_icache_flush = true;
+			/*
+			 * This pairs with the smp_rmb() in
+			 * switch_to_should_flush_icache() to ensure that the
+			 * icache is flushed when this thread is migrated.
+			 */
+			smp_wmb();
 			break;
 		default:
 			return -EINVAL;
@@ -240,13 +258,22 @@ int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
 		switch (scope) {
 		case PR_RISCV_SCOPE_PER_PROCESS:
 			current->mm->context.force_icache_flush = false;
-
+			/*
+			 * This pairs with the smp_rmb() in
+			 * switch_to_should_flush_icache() to ensure that other
+			 * harts using the same mm stop flushing the icache on migration.
+			 */
+			smp_wmb();
 			set_icache_stale_mask();
 			break;
 		case PR_RISCV_SCOPE_PER_THREAD:
 			current->thread.force_icache_flush = false;
-
-			set_icache_stale_mask();
+			/*
+			 * This pairs with the smp_rmb() in
+			 * switch_to_should_flush_icache() to ensure that the
+			 * icache stops flushing when this thread is migrated.
+			 */
+			smp_wmb();
 			break;
 		default:
 			return -EINVAL;
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 4abe3de23225..6d3560380e72 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -299,18 +299,18 @@ static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
 					 struct task_struct *task)
 {
 #ifdef CONFIG_SMP
+	/*
+	 * This pairs with the smp_wmb() in set_icache_stale_mask() to
+	 * synchronize this hart with changes to mm->context.icache_stale_mask.
+	 */
+	smp_rmb();
 	if (cpumask_test_and_clear_cpu(cpu, &mm->context.icache_stale_mask)) {
 		/*
 		 * Ensure the remote hart's writes are visible to this hart.
 		 * This pairs with a barrier in flush_icache_mm.
 		 */
 		smp_mb();
-
-		/*
-		 * If cache will be flushed in switch_to, no need to flush here.
-		 */
-		if (!(task && switch_to_should_flush_icache(task)))
-			local_flush_icache_all();
+		local_flush_icache_all();
 	}
 #endif
 }

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240812-fix_fencei_optimization-3f81ac200505
-- 
- Charlie


