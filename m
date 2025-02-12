Return-Path: <linux-kernel+bounces-510672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE06A32045
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E81A3A95BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9C22046A4;
	Wed, 12 Feb 2025 07:50:05 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9841D201268
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346605; cv=none; b=m+0yCfy9/SZxT6uVVz9f22R7/dy8V/25QucBlLcfVS7t06oFw0z7j4vVJ3fXKi5aGOcnTPDC4JJJ0FVhUfhv+UU66SyZ12fuoiRWf9MMDHmCPusb5BtzyUTZJ235+0t4x89Kv184Kl7JS7Hv/EuZZ5CBJ2wNqkaN/kt3MXy6H1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346605; c=relaxed/simple;
	bh=AOpEiDRdv/zMfMTCdXM0iJQaQUXHegfeysZkTKSnhmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgbvPLCa7XiJPRlEv3cwc4SV60YZLbfHJF5LGZn4QsPrfvInzxKhlfq5t/lRWMfDJbd2bZuVnOQzkyNC4gZQ4zgoQwe8Pc7nQCIlTozOUvjD05mHUTTC4KAmfgxFYmJxLw2zkeaizvu/pGcGWFxN9tmoo7MxSizrhdpbpd5yQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Yt9GW2gRHz9sSf;
	Wed, 12 Feb 2025 08:40:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id win_Exv7QbtN; Wed, 12 Feb 2025 08:40:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Yt9GW1hD6z9sSd;
	Wed, 12 Feb 2025 08:40:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 110AF8B770;
	Wed, 12 Feb 2025 08:40:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id X0yeLhePcO08; Wed, 12 Feb 2025 08:40:51 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [10.25.207.138])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DF78E8B763;
	Wed, 12 Feb 2025 08:40:50 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Don't use --- in kernel logs
Date: Wed, 12 Feb 2025 08:40:48 +0100
Message-ID: <54a1f8d2c3fb5b95434039724c8c141052ae5cc0.1739346038.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739346048; l=2323; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=AOpEiDRdv/zMfMTCdXM0iJQaQUXHegfeysZkTKSnhmE=; b=HnFm4QGgZpVbWmsHfAv54PYdo8ORxP8uSAGUO5YwkXdvYNyyO0KcFrr9cj+Rso5TvF0E78nS5 KtDuxVk6pLLA6eTap+dpy3Bg0u7HmZEguEMpQw94EZzFrQNBs5wa4TA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

When a kernel log containing --- at the start of a line is copied into
a patch message, 'git am' drops everything located after that ---.

Replace --- by ---- to avoid that.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/process.c | 8 ++++----
 arch/powerpc/xmon/xmon.c      | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ef91f71e07c4..855e09886503 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1000,7 +1000,7 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
 
 	WARN_ON(tm_suspend_disabled);
 
-	TM_DEBUG("--- tm_reclaim on pid %d (NIP=%lx, "
+	TM_DEBUG("---- tm_reclaim on pid %d (NIP=%lx, "
 		 "ccr=%lx, msr=%lx, trap=%lx)\n",
 		 tsk->pid, thr->regs->nip,
 		 thr->regs->ccr, thr->regs->msr,
@@ -1008,7 +1008,7 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
 
 	tm_reclaim_thread(thr, TM_CAUSE_RESCHED);
 
-	TM_DEBUG("--- tm_reclaim on pid %d complete\n",
+	TM_DEBUG("---- tm_reclaim on pid %d complete\n",
 		 tsk->pid);
 
 out_and_saveregs:
@@ -2367,14 +2367,14 @@ void __no_sanitize_address show_stack(struct task_struct *tsk,
 				(sp + STACK_INT_FRAME_REGS);
 
 			lr = regs->link;
-			printk("%s--- interrupt: %lx at %pS\n",
+			printk("%s---- interrupt: %lx at %pS\n",
 			       loglvl, regs->trap, (void *)regs->nip);
 
 			// Detect the case of an empty pt_regs at the very base
 			// of the stack and suppress showing it in full.
 			if (!empty_user_regs(regs, tsk)) {
 				__show_regs(regs);
-				printk("%s--- interrupt: %lx\n", loglvl, regs->trap);
+				printk("%s---- interrupt: %lx\n", loglvl, regs->trap);
 			}
 
 			firstframe = 1;
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 268859e4df87..042793b5be78 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1787,7 +1787,7 @@ static void xmon_show_stack(unsigned long sp, unsigned long lr,
 				       sp + STACK_INT_FRAME_REGS);
 				break;
 			}
-			printf("--- Exception: %lx %s at ", regs.trap,
+			printf("---- Exception: %lx %s at ", regs.trap,
 			       getvecname(TRAP(&regs)));
 			pc = regs.nip;
 			lr = regs.link;
-- 
2.47.0


