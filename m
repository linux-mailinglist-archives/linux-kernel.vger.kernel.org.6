Return-Path: <linux-kernel+bounces-567406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5057BA6858C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8941F7A2A72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1332224EAAA;
	Wed, 19 Mar 2025 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="p0Sh1+uR"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3BE7E1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368244; cv=none; b=Cb5jyOQJdoXJy2MU87qlKx0YetZ/ibjbpAXGwly5lXSHflc6zjPoRDl8zj00CHMCQKkuM6seHndG0b9RaYWUzZTioiTknXhPUNPdIXwLPfcpwqzkBmy/nwJXR5dlbB1e5iEtnx7gQB3JNNG/CytC6k5woYhdDNgYfeuzS1GPCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368244; c=relaxed/simple;
	bh=67mquUiE4jRb5cRtxhRlrVn3uvsHCckD7ZfA78Cx+o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiB31BnOuRm3hnwqpR4wkCXxgWGn2XpzWoEoke3LGFIUnDdRqSoIPr/HcnYh/ixFpLJRHA4TdIVBtiNCNG1pudccMgXehbMlfnQRyfO7bp/za2jqIOTv0b/dMTrZgqjSd6nErNTh35AH9rSDCWg8i1gFNIamlsSNQyBYlU5JMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=p0Sh1+uR; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52J7A9qf1391002
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 19 Mar 2025 00:10:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52J7A9qf1391002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742368218;
	bh=kCzkHdkBZ2wpjZQ6wuq91+umQKru+fFf3F1VS892Xh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0Sh1+uRQTxTu3IkDo/7es1Zr0/x6HTLQSETI/tbr354mgndjP0ts5LpUNThE4Sd2
	 gDw1oVylNIVAsTT95G3jFK9wZINvbC8M8Mbkv/Joo2aflUodBK0Iuu/lJicmuhcTHg
	 E9VHPp6kYmLrZQcEcMlQ0zIjX6Ffnwoq8a5C3VMRi2ZrWdUVcX/+EMuMGuIUyyAlbC
	 Lt96HlMdVFURZviYU4bb5ngOkiRrns346NqxtDzZp3ix1nsoj+M6HdHkdtWwl2WV5C
	 PMzRwvf9pZofVgtfZnCHmCg0dAEhmqehKkZZLZmCreXCNlZH2MchF+ER+DXBXHtPyo
	 qS0muy2zs9W1A==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [PATCH v3 2/3] x86: Remove the padding space at top of the init stack
Date: Wed, 19 Mar 2025 00:10:08 -0700
Message-ID: <20250319071009.1390984-3-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319071009.1390984-1-xin@zytor.com>
References: <20250319071009.1390984-1-xin@zytor.com>
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
 arch/x86/kernel/vmlinux.lds.S    |  7 +++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 7ff3443eb57d..a88ddf5614f2 100644
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
index ccdc45e5b759..b2df61293a20 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -178,8 +178,11 @@ SECTIONS
 		/* init_task */
 		INIT_TASK_DATA(THREAD_SIZE)
 
-		/* equivalent to task_pt_regs(&init_task) */
-		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
+		/*
+		 * task_pt_regs(&init_task) is:
+		 *	'(struct pt_regs *)&__end_init_stack - 1'
+		 */
+		__top_init_kernel_stack = __end_init_stack - PTREGS_SIZE;
 
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
-- 
2.48.1


