Return-Path: <linux-kernel+bounces-565583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3774CA66B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D519189B6B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C8D1EB5CC;
	Tue, 18 Mar 2025 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DaZ+m395"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B11DF723
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742281714; cv=none; b=W1+/D8pjLxR2krjAVyNx0lSpswQYUrt6y9ayWMANXdDNWJBgu0l68deDOgXJflMkMSz1lOWqeXvQyDQNaklzpqi/+ERQGCKDq06x3It6h4qF6XhWm/8HN9NxNw1mwTWTdTn0LQ4+dkS3gNT8A6N5b2okZd+QOBB1JQ9oo0iw/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742281714; c=relaxed/simple;
	bh=zTnj8QhYxgiH4oPOrtLPU42PD/HqWJyjwEsRbY2TcYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJMRjFVYtuLcJAb3Mz/4FDl3gdjLoHaYpdprXOTx9PAV+mkG7WMUuqpbnBhcg0Etq89T2C2a8pJMeHwJGNCQ5ydiEV8tm+8iH1cG3jb0ef33MI7mgipYeTMMjM/4aWAaxD7iaMhNTB0aIseb4b9iH5x84SMsrJVR4188X5nTyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DaZ+m395; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52I781gp903065
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 18 Mar 2025 00:08:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52I781gp903065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742281686;
	bh=KINlIhnlBijRhggk1EdE5/Vw4yhAXDRAjMRm+dGrZgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DaZ+m395hvTvPvpwQGFICIDEZ+YF0FvNu27+iZVuOSM0OEAlKx85kh60IrkBQiY/O
	 4YEdIPFqTz1LrpYFgb3+nm8YrfPMwzlWtoLvC1w6AtRbc0LLiW6sUg30WZwwrcMvSM
	 Lri6FxCHYl1F5/6Ckz6KisNOWZ89+yZeRcU3ljiLgdvcINe8bepT++hAcAWrJF3PGf
	 KshQZ90WmYTEaY5DhwKFGhtI9WNCxOcyc368nLVs2qL4/y5XCwboaz/jsXxhVzk2Uh
	 Rh1PrO+0MQQHAYV2YnbMaPcA2ESwBMHgY2Nz8i9XYHicmm/5WevY1DMb0dOuxb63bg
	 DRz6rxfYwIFQg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [PATCH v2 2/3] x86: Remove the padding space at top of the init stack
Date: Tue, 18 Mar 2025 00:08:00 -0700
Message-ID: <20250318070801.903045-3-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318070801.903045-1-xin@zytor.com>
References: <20250318070801.903045-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because the owner of the init stack, init task, doesn't have any user
level context, there will NEVER be an actual pt_regs structure pushed
at top of the init stack.

However a zeroed pt_regs structure is created at build time and kept
at top of the init stack for task_pt_regs() to function properly with
the init task in the same manner as a normal task with user level
context.

Besides, task_pt_regs() no longer converts a fixed offset from top of
a task kernel stack to a pt_regs structure pointer, but rather returns
whatever in the thread_info.user_pt_regs field, which is initialized
at build time to '(struct pt_regs *)TOP_OF_INIT_STACK - 1' for the
init task.

As a result, there is no point to reserve any padding space at top of
the init stack, so remove the padding space.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/processor.h | 16 ++++++++++++++--
 arch/x86/kernel/vmlinux.lds.S    | 18 ++++++++++++++++--
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 79d8df28cd59..cbb5d2158075 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -641,8 +641,20 @@ static __always_inline void prefetchw(const void *x)
 			  "m" (*(const char *)x));
 }
 
-#define TOP_OF_INIT_STACK ((unsigned long)&init_stack + sizeof(init_stack) - \
-			   TOP_OF_KERNEL_STACK_PADDING)
+extern unsigned long __end_init_stack[];
+
+/*
+ * No need to reserve extra padding space above the pt_regs structure
+ * at top of the init stack, because its owner init task doesn't have
+ * any user level context, thus there will NEVER be an actual pt_regs
+ * structure pushed at top of the init stack.
+ *
+ * However a zeroed pt_regs structure is created at build time and kept
+ * at top of the init stack for task_pt_regs() to function properly with
+ * the init task in the same manner as a normal task with user level
+ * context.
+ */
+#define TOP_OF_INIT_STACK ((unsigned long)&__end_init_stack)
 
 #define task_top_of_stack(task) ((unsigned long)(task_pt_regs(task) + 1))
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index ccdc45e5b759..553b65e8bb8a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -178,8 +178,22 @@ SECTIONS
 		/* init_task */
 		INIT_TASK_DATA(THREAD_SIZE)
 
-		/* equivalent to task_pt_regs(&init_task) */
-		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
+		/*
+		 * No need to reserve extra padding space above the pt_regs
+		 * structure at top of the init stack, because its owner
+		 * init task doesn't have any user level context, thus there
+		 * will NEVER be an actual pt_regs structure pushed at top
+		 * of the init stack.
+		 *
+		 * However a zeroed pt_regs structure is created at build
+		 * time and kept at top of the init stack for task_pt_regs()
+		 * to function properly with the init task in the same manner
+		 * as a normal task with user level context.
+		 *
+		 * task_pt_regs(&init_task) is now:
+		 *	'(struct pt_regs *)&__end_init_stack - 1'
+		 */
+		__top_init_kernel_stack = __end_init_stack - PTREGS_SIZE;
 
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
-- 
2.48.1


