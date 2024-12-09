Return-Path: <linux-kernel+bounces-437052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3999E8E79
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5FF1886603
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2965021571D;
	Mon,  9 Dec 2024 09:12:37 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44500215714
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735556; cv=none; b=hEK4ncoanyEMYUAC3XOXsGIxkhEvXvOsghee+evET/7UkUiC9Cn4RxqA7p/HwPFX2sD/JpC80UpnD9mx8jfiBYwB3zxxEHo8E+vIEx/sMsbWDYIyxVnteEsoSDZgSRcFuweaoTot+BgJesTEhI0ZryjC6xfUJY6LPjTc6NQdJbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735556; c=relaxed/simple;
	bh=RnNHQNv9kB3kJ2am9B8ld8ft13Sf8gJDWi+AxfEF5t4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YeTsvctQnZPAU74MTugDY7EGgBJd7O0eG+XPAm1yKUvqWkvwk7H3J3xqKRNZ1grjuxzHOtuTTCxPaPx9qjchS6hse9Y6MDunHVk/Ozdq5oYwos/nQSYqZQiUCcK5zrTeD7L5mZWEDDMuMQ+5nUNbey3n+sUOlP+heukSxRIJY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y6GKX3tR5zhZVc;
	Mon,  9 Dec 2024 17:10:08 +0800 (CST)
Received: from kwepemd200025.china.huawei.com (unknown [7.221.188.181])
	by mail.maildlp.com (Postfix) with ESMTPS id E76F118006C;
	Mon,  9 Dec 2024 17:12:30 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.247) by
 kwepemd200025.china.huawei.com (7.221.188.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Dec 2024 17:12:30 +0800
From: pangliyuan <pangliyuan1@huawei.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: <anju@linux.vnet.ibm.com>, <mhiramat@kernel.org>, <maddy@linux.ibm.com>,
	<naveen@kernel.org>, <christophe.leroy@csgroup.eu>, <npiggin@gmail.com>,
	<mpe@ellerman.id.au>, <wangfangpeng1@huawei.com>, <heyuqiang1@huawei.com>,
	pangliyuan <pangliyuan1@huawei.com>
Subject: [PATCH] powerpc/kprobes: don't save r13 register in kprobe context
Date: Mon, 9 Dec 2024 17:10:39 +0800
Message-ID: <20241209091039.72786-1-pangliyuan1@huawei.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200025.china.huawei.com (7.221.188.181)

When CONFIG_STACKPROTECTOR_STRONG is enabled and FTRACE is disabled on
powerpc64, repeatedly triggering the kprobe process may cause stack check
failures and panic.

Case:
There is a kprobe(do nothing in handler) attached to the "shmem_get_inode",
and a process A is creating file on tmpfs.

                           CPU0
A |r13 = paca_ptrs[0], paca_ptrs[0]->canary=A->stack_canary
  |touch a file on tmpfs
  |shmem_mknod():
  |    load A's canary through r13 and stored it in A's stack
  |    shmem_get_inode():
  |        enter kprobe first
  |        optinsn_slot():
  |            stored r13 (paca_ptrs[0]) in stack

  ......

  ==> schedule,  B run on CPU0, A run on CPU1

			   CPU0
B |r13 = paca_ptrs[0], paca_ptrs[0]->canary=B->stack_canary
  |do something...
                           CPU1
A |            r13 = paca_ptrs[1], paca_ptrs[1]->canary=A->stack_canary
  |            about to leave 'optinsn_slot', restore r13 from A's stack
  |            r13 = paca_ptrs[0], paca_ptrs[0]->canary=B->stack_canary
  |            leave optinsn_slot, back to shmem_get_inode
  |        leave shmem_get_inode, back to shmem_mknod
  |    do canary check in shmem_mknod, but canary stored in A's stack (A's
       canary) doesn't match the canary loaded through r13 (B's canary),
       so panic

When A(on CPU0) entring optinsn_slot, it stored r13(paca_ptrs[0]) in stack,
then A is scheduled to CPU1 and restore r13 from A's stack when leaving
'optinsn_slot'. Now A is running on CPU1 but r13 point to CPU0's
paca_ptrs[0], at this time paca_ptrs[0]->__current points to another
process B, which cause A use B's canary to do stack check and panic.

This can be simply fixed by not saving and restoring the r13 register,
because on powerpc64, r13 is a special register that reserved to point
to the current process, no need to restore the outdated r13 if scheduled
had happened.

Fixes: 51c9c0843993 ("powerpc/kprobes: Implement Optprobes")
Signed-off-by: pangliyuan <pangliyuan1@huawei.com>
---
 arch/powerpc/kernel/optprobes_head.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/optprobes_head.S b/arch/powerpc/kernel/optprobes_head.S
index 35932f45fb4e..bf0d77e62ba8 100644
--- a/arch/powerpc/kernel/optprobes_head.S
+++ b/arch/powerpc/kernel/optprobes_head.S
@@ -10,12 +10,12 @@
 #include <asm/asm-offsets.h>
 
 #ifdef CONFIG_PPC64
-#define SAVE_30GPRS(base) SAVE_GPRS(2, 31, base)
-#define REST_30GPRS(base) REST_GPRS(2, 31, base)
+#define SAVE_NEEDED_GPRS(base) SAVE_GPRS(2, 12, base); SAVE_GPRS(14, 31, base)
+#define REST_NEEDED_GPRS(base) REST_GPRS(2, 12, base); REST_GPRS(14, 31, base)
 #define TEMPLATE_FOR_IMM_LOAD_INSNS	nop; nop; nop; nop; nop
 #else
-#define SAVE_30GPRS(base) stmw	r2, GPR2(base)
-#define REST_30GPRS(base) lmw	r2, GPR2(base)
+#define SAVE_NEEDED_GPRS(base) stmw	r2, GPR2(base)
+#define REST_NEEDED_GPRS(base) lmw	r2, GPR2(base)
 #define TEMPLATE_FOR_IMM_LOAD_INSNS	nop; nop; nop
 #endif
 
@@ -45,7 +45,7 @@ optprobe_template_entry:
 	/* Save the previous SP into stack */
 	addi	r0,r1,INT_FRAME_SIZE
 	PPC_STL	r0,GPR1(r1)
-	SAVE_30GPRS(r1)
+	SAVE_NEEDED_GPRS(r1)
 	/* Save SPRS */
 	mfmsr	r5
 	PPC_STL	r5,_MSR(r1)
@@ -123,7 +123,7 @@ optprobe_template_call_emulate:
 	PPC_LL	r5,_CCR(r1)
 	mtcr	r5
 	REST_GPR(0,r1)
-	REST_30GPRS(r1)
+	REST_NEEDED_GPRS(r1)
 	/* Restore the previous SP */
 	addi	r1,r1,INT_FRAME_SIZE
 
-- 
2.37.7


