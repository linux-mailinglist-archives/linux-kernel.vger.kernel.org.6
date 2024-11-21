Return-Path: <linux-kernel+bounces-416518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4299D464B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D246B22CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD601C75E4;
	Thu, 21 Nov 2024 03:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="dOaC+5qo"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D601482E2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 03:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732160555; cv=none; b=UMcqfW5sczqocTOTnx3N8HCFh3RLaO/Oq1yzDJWQQHA3aTYgVK851hxSXVyUlJwIGc4fZ1I7y4IGx4rllLvfsdHV9JGrjJF8kOiPpZgdpNMZsbqqnAxe3zj2KA4UADTfw0dilT7Xqp2eCCyXXRTi7qfwMpVDLDchONqndeuhZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732160555; c=relaxed/simple;
	bh=v8WDhRD588WyC3JfIza6TUPqo5yDPJGeOfKn/c8vHsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4fmFaa7PYhJQ8bfvAQhqgWInfNV2+6au8bst4QCQ0UxJ6ECX824dFI7EgyqiO6En15HjNJF4RNnltmc68jLKrEDqudA/vkRoMqOjEbLsFPWUlNigtaDBJyBm/J5OrK8nnL0nraA/Fb+ZeZaaCqxJuf4TpYatjvo+xdRfXkKXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=dOaC+5qo; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1732160544;
	bh=+D9hzwSmuDs0d2M01TQ0YU//VDWH5zv+hc9Rt5E5zho=;
	h=From:To:Cc:Subject:Date:From;
	b=dOaC+5qoSvxtFF965lM3Z40nK2qen3oXUzPQ9ZV3qaJVUI8904/XS/TrZ85uS0gJF
	 tN7Gz7bT1MwenCXHM2O+GnmVU8oycJJzGQNxZyFZjuFG9bfGUAZpV0ztxfhIN4zODd
	 F8RvcyZBRON4IEv6qsOjcf5U5yaATu/gWplRjNRM=
Received: from stargazer.. (unknown [IPv6:240e:358:1182:2e00:dc73:854d:832e:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 3153B1A3EC3;
	Wed, 20 Nov 2024 22:42:18 -0500 (EST)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Jinyang He <hejinyang@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] LoongArch: Add PREEMPT_LAZY support
Date: Thu, 21 Nov 2024 11:41:28 +0800
Message-ID: <20241121034127.8325-2-xry111@xry111.site>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like x86 and RISC-V, we are using GENERIC_ENTRY so supporting
PREEMPT_LAZY just needs to allocate a bit in thread flags.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/Kconfig                   | 1 +
 arch/loongarch/include/asm/thread_info.h | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d9fce0fd475a..b8cc5997d595 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -25,6 +25,7 @@ config LOONGARCH
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/include/asm/thread_info.h
index 8bf0e6f51546..fd68a6d81b8e 100644
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -66,8 +66,9 @@ register unsigned long current_stack_pointer __asm__("$sp");
  * - pending work-to-be-done flags are in LSW
  * - other flags in MSW
  */
-#define TIF_SIGPENDING		1	/* signal pending */
-#define TIF_NEED_RESCHED	2	/* rescheduling necessary */
+#define TIF_NEED_RESCHED	0	/* rescheduling necessary */
+#define TIF_NEED_RESCHED_LAZY	1	/* Lazy rescheduling needed */
+#define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NOTIFY_RESUME	3	/* callback before returning to user */
 #define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
 #define TIF_RESTORE_SIGMASK	5	/* restore signal mask in do_signal() */
@@ -88,8 +89,9 @@ register unsigned long current_stack_pointer __asm__("$sp");
 #define TIF_LBT_CTX_LIVE	20	/* LBT context must be preserved */
 #define TIF_PATCH_PENDING	21	/* pending live patching update */
 
-#define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
+#define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 #define _TIF_NOHZ		(1<<TIF_NOHZ)

base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
-- 
2.47.0


