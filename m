Return-Path: <linux-kernel+bounces-293860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943699585D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27F69B269F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C6D18E04E;
	Tue, 20 Aug 2024 11:29:38 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED718E05E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153378; cv=none; b=k3RuEpjdT209ocupqBPWaFCutJ1ORCANd5nJ4yVcyKfOiZcU46IskXRKuebCsPY+/Uy1M1CjULacKqHgNU7eJJ8MI77kVv3lVUTXX88VshdwX2OdFn4PxEqIBJI3dVeQmcs0vH8TK0s9L+JNwaF+WMRbiTEvquQJm1umYLIsKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153378; c=relaxed/simple;
	bh=c0emP5AnuWUNCjldEyQ/AyyFq9iE703od3heeSMBWjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5uP7q1oLLMgVzEYKjlB9jMvOmhNXmROEdWfhLcKwif1mX5JNWEvuSooGMXQ9U4/R/quyIB9hqe4zya0Xcis2CkwngNWISCbl1qEqUzt6AVRyQHAhPSlKIBJ2gvuq1nNVDsRQUBWOdToGiPm2QhWtGjiLDezkXBcEQ2yJKf/9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wp6gf1NNXz9sSK;
	Tue, 20 Aug 2024 13:29:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uw0Vjelo8sGw; Tue, 20 Aug 2024 13:29:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wp6gf0gT9z9sSH;
	Tue, 20 Aug 2024 13:29:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 07F0A8B778;
	Tue, 20 Aug 2024 13:29:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Y2Z32C1pNq0Z; Tue, 20 Aug 2024 13:29:33 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A4EA78B763;
	Tue, 20 Aug 2024 13:29:33 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/32: Implement validation of emergency stack
Date: Tue, 20 Aug 2024 13:29:30 +0200
Message-ID: <d7409df92b315e950f7837f7f86614c46360842a.1724153301.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724153371; l=2220; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=c0emP5AnuWUNCjldEyQ/AyyFq9iE703od3heeSMBWjU=; b=wSh1XI/C90bVl5Hk3irgOmsQixgqOezR0tDiNdlkWt+qUyUhBlXHH4EyS5TIk58fRhHcu4Jet 3r9K+HdeYYaDUS8H2fPWzAOEm71XpnQAoMSI5mfoYfMF/2OIwyCqrje
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

VMAP stack added an emergency stack on powerpc/32 for when there is
a stack overflow, but failed to add stack validation for that
emergency stack. That validation is required for show stack.

Implement it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/thread_info.h |  4 ++++
 arch/powerpc/kernel/process.c          | 20 ++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 15c5691dd218..d2f356e57387 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -226,6 +226,10 @@ static inline int arch_within_stack_frames(const void * const stack,
 	return BAD_STACK;
 }
 
+#ifdef CONFIG_VMAP_STACK
+extern void *emergency_ctx[];
+#endif
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 3b506d4c55f3..b27e2f69930c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2177,10 +2177,10 @@ static inline int valid_irq_stack(unsigned long sp, struct task_struct *p,
 	return 0;
 }
 
+#ifdef CONFIG_PPC64
 static inline int valid_emergency_stack(unsigned long sp, struct task_struct *p,
 					unsigned long nbytes)
 {
-#ifdef CONFIG_PPC64
 	unsigned long stack_page;
 	unsigned long cpu = task_cpu(p);
 
@@ -2208,10 +2208,26 @@ static inline int valid_emergency_stack(unsigned long sp, struct task_struct *p,
 	if (sp >= stack_page && sp <= stack_page + THREAD_SIZE - nbytes)
 		return 1;
 # endif
-#endif
 
 	return 0;
 }
+#else
+static inline int valid_emergency_stack(unsigned long sp, struct task_struct *p,
+					unsigned long nbytes)
+{
+	unsigned long stack_page;
+	unsigned long cpu = task_cpu(p);
+
+	if (!IS_ENABLED(CONFIG_VMAP_STACK))
+		return 0;
+
+	stack_page = (unsigned long)emergency_ctx[cpu] - THREAD_SIZE;
+	if (sp >= stack_page && sp <= stack_page + THREAD_SIZE - nbytes)
+		return 1;
+
+	return 0;
+}
+#endif
 
 /*
  * validate the stack frame of a particular minimum size, used for when we are
-- 
2.44.0


