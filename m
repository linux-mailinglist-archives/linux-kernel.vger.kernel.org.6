Return-Path: <linux-kernel+bounces-293953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0A39586DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2145E281E74
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091ED18FC91;
	Tue, 20 Aug 2024 12:27:01 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6E2745C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156820; cv=none; b=ZEL2yIepgspWd6jE0JzjC1KYuozGMbaOEByHpOAxkghbhCdAuVXWiS0GajVAQEGpKxIBUj9wrtVxi+MbpMsBok7lR/nWcuvxYPdLSUWOFaMeKf5wR7LWnv1BMawB0n8NPrtvAmAaQfdMVM8tx2GI289YCeD7rJjHSCwXWJqa3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156820; c=relaxed/simple;
	bh=BWZw2MPfPwSDfcLX6WTR02N0kEVf4r9w0eZ+/NHSGxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXauKvYkylXfjhTtPAWEOSppIciQ6Kvh/vxy5vaFr+U2KiOcB4z1h71ARDhmT3+hwbQYGkWOrPp1KD+xohKyQm5CQL0hlqJV90xZKSEbDP7SpUeLRfESihqQ24IZ05KJBFo8+stKEWuIvUvg3tENiCszZS0Len0YbxZ351OtSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wp7xr4pfXz9sSK;
	Tue, 20 Aug 2024 14:26:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pQek20mursXK; Tue, 20 Aug 2024 14:26:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wp7xr46dnz9sSH;
	Tue, 20 Aug 2024 14:26:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7CD268B778;
	Tue, 20 Aug 2024 14:26:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id QOfkP72dwvAA; Tue, 20 Aug 2024 14:26:56 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 27C318B763;
	Tue, 20 Aug 2024 14:26:56 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/32: Implement validation of emergency stack
Date: Tue, 20 Aug 2024 14:26:54 +0200
Message-ID: <2439d50b019f758db4a6d7b238b06441ab109799.1724156805.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724156815; l=2297; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=BWZw2MPfPwSDfcLX6WTR02N0kEVf4r9w0eZ+/NHSGxM=; b=FZyqSmh/WhnVZ0QjtIFt+cwme4B+jNwJ0m6bFWOOphpagOF9t+7ai27sjaM1J2H6YMnxp8M7B 9ifMAdk8MY+AD4zPZueXpjMbMX5GDbWuswA79/foODBEzvRBTAEEE+W
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

VMAP stack added an emergency stack on powerpc/32 for when there is
a stack overflow, but failed to add stack validation for that
emergency stack. That validation is required for show stack.

Implement it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Declare emergency_ctx[] at all time, not only when CONFIG_VMAP_STACK is set
---
 arch/powerpc/include/asm/thread_info.h |  4 ++++
 arch/powerpc/kernel/process.c          | 20 ++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 15c5691dd218..6ebca2996f18 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -226,6 +226,10 @@ static inline int arch_within_stack_frames(const void * const stack,
 	return BAD_STACK;
 }
 
+#ifdef CONFIG_PPC32
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


