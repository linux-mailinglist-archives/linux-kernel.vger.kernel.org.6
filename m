Return-Path: <linux-kernel+bounces-216931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB58090A8B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6313B2852C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F119069B;
	Mon, 17 Jun 2024 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ba+8YBYS"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD0154918
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613975; cv=none; b=g9RRV/Nz+QbdvyHTpiOtIonl02yNPIeV8ii8WLFZGfjUf1HDeWrE7aO9wj7bjdDGtCbFQN60wddywcI9L4ikVDIwGn/GSUueQjrayYvkrn0uhUCZcEZddTKvMnmH2GJtfTcbF1U9LkHOzzyeD2qellBpDtfp+IOAJtjTgjVvACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613975; c=relaxed/simple;
	bh=rA4VS4FxTvDCKx3FhWhSHsbZyMK4lV2SdapRQhVPjE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWTei6c6vtQSmiDvxt7Cd6Gn9ELvXkDLii+JW7ANfD/HEL9ow286G79Xxbc0f4zpxj2DYBprPvuSsAu0EcbQr8syfl34EQBLJY/xRSmgoBQEWvoEVzZG3GUQIiueJVIreU77PrXvsxOLb2vEiFSYBn7b1moaNktdJ2Jh/KQYhWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Ba+8YBYS; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45H8jGt31484406
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 17 Jun 2024 01:45:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45H8jGt31484406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1718613922;
	bh=rlj70q5uzhl4dfMY8LHCyKumd5neSWNSwo53XAQwPq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ba+8YBYSJP82QeOXi8oTyqiHr+sHbNtSqulRty2SF87oUoSklT1FwdYAWlt4pi+Iq
	 MwOrEkYryDSrWfNbEt2y41S1RtNNmACK8zQSVvchqfiFg6xWXxGPAeBullK8lUeMYs
	 17QIEjkFbf3kQkc8Zt8V6fkRUbzWHiARU8cfEu9QJmfwn2GyG/AsgV1Lny9ZHrNPK0
	 KqHMBEhqOa4dRlcoMXu5qCheQMl+iTe3LmnVt4wVl8dMHd12faIO1Y2fg+5p8J3jM2
	 JbeKd9n5C0N4pcTTgRIMb1hv2TilWYgs4ZL2y835wwaUVrP84ZOuQ5F0nN8rZeKtqI
	 7Wl5RjkmlOxWw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [PATCH v1 2/3] x86: Remove the padding space at top of the init stack
Date: Mon, 17 Jun 2024 01:45:14 -0700
Message-ID: <20240617084516.1484390-3-xin@zytor.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240617084516.1484390-1-xin@zytor.com>
References: <20240617084516.1484390-1-xin@zytor.com>
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
index ea7733e7bf1d..91803844c4d7 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -629,8 +629,20 @@ static __always_inline void prefetchw(const void *x)
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
index 3509afc6a672..b440928191c4 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -167,8 +167,22 @@ SECTIONS
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
2.45.1


